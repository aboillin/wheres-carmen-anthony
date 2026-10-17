from pathlib import Path
import pandas as pd 

WORKBOOK = "../achilala-repo/carmen_sightings/carmen_sightings_20220629061307.xlsx"
SEEDS =  "../dbt/seeds"

if not Path(WORKBOOK).exists():
    raise FileNotFoundError("Workbook not found")

if not Path(SEEDS).exists():
    raise FileNotFoundError("seeds folder not found")

sheets = pd.read_excel(
    Path(WORKBOOK),
    sheet_name=None,        # When None, will return a dictionary containing DataFrames for each sheet. https://pandas.pydata.org/docs/reference/api/pandas.read_excel.html
    dtype=str,              # keep everything as text; dbt staging casts types later
    keep_default_na=False,  # don't turn values like "NA" or empty cells into NaN
)


for sheet_name, df in sheets.items():
    output_path = Path(SEEDS)/f"{sheet_name.lower()}.csv"   # lower the name of the sheet in the seed
    df.to_csv(
        output_path,
        index=False,        # no need index column in the seed
        encoding="utf-8"    # utf-8 keeps the Chinese headers in ASIA intact
    )

    print(f"{sheet_name} {len(df)} rows -> {output_path}")
