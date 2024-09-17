import pandas as pd
from rename import *
import pytz


lista1 = ["CA-HU-01", "CA-HU-04", "CA-HU-09"]

lista2 = ["CA-HU-01 HISTORICO 1h_", "CA-HU-04 HISTORICO 1h_", "CA-HU-09 HISTORICO 1h_"]




df_update = pd.DataFrame()
df_historical = pd.DataFrame()

last_hour_history = int()
new_hour_update = int()

msg = str()

def load_data(df_update, df_historical, update_data, historical_data):
    df_update = pd.read_excel(update_data)
    df_historical = pd.read_csv(historical_data, sep=";")

    df_historical['date'] = pd.to_datetime(df_historical['date'], utc=True)
    df_update['date'] = pd.to_datetime(df_update['date'], utc=True)

    return df_update, df_historical

def find_nat(df_update):

    invalid_rows = df_update[df_update['date'].isna()]

    if not invalid_rows.empty:
        print("Filas con valores no datetime en la columna 'date':")
        print(invalid_rows)

def clean_data(df_update):
    erase_columns = [x for x in rename_columns.keys() if x in df_update.columns]
    df_update = df_update[erase_columns]

    df_update.rename(columns=rename_columns.copy(), inplace=True)
    df_update['PBAR_hpa'] = round(df_update['PBAR_mmHg'] * 1.3332,1)

    erase_columns = [x for x in rename_columns.values() if x in df_update.columns]
    df_update = df_update[erase_columns]

    return df_update

def find_dates(last_hour_history, new_hour_update):
    last_hour_history = df_historical.at[df_historical.index[-1], 'date']
    new_hour_update = df_update.at[df_update.index[0], 'date']

    return last_hour_history, new_hour_update

def updating(msg, df_historical):
    if new_hour_update == (last_hour_history  + pd.DateOffset(hours=1)):

        df_historical = pd.concat([df_historical, df_update], ignore_index=True)
        msg = f"Todo Okey, se realizo la actualización a {historical_data}"

    elif last_hour_history > new_hour_update:

        msg = f"El archivo {historical_data}, ya estaba actualizado"

    elif new_hour_update > (last_hour_history  + pd.DateOffset(hours=1)):

        msg = f"Hay fechas faltantes en el archivo {historical_data}"

    else:

        msg = "Ocurrio un error inesperado"

    df_historical['date'] = df_historical['date'].dt.strftime('%Y-%m-%d %H:%M:%S %Z')

    return msg, df_historical

if __name__ == "__main__":

    for x in range(len(lista1)):

        update_data = "xls/" + lista1[x] + ".xlsx"

        historical_data = lista2[x]  + ".csv"

        df_update, df_historical = load_data(df_update, df_historical, update_data, historical_data)
        find_nat(df_update)
        df_update =clean_data(df_update)
        last_hour_history, new_hour_update = find_dates(last_hour_history, new_hour_update)
        msg, df_historical = updating(msg, df_historical)



        print(df_historical.tail())

        df_historical.to_csv(historical_data, sep=';', index=False)

        print(msg)

        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXX")


