// Power Query (M) for table: Features data set
// Update the file path below to where you saved the CSV.
let
    Source = Csv.Document(File.Contents("C:\Users\pinna\Downloads\Retail_Data\Retail_Data\Retail_Data\Features data set.csv"),[Delimiter=",", Columns=12, Encoding=874, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Store", Int64.Type}, {"Date", type date}, {"Temperature", type number}, {"Fuel_Price", type number}, {"MarkDown1", type number}, {"MarkDown2", type number}, {"MarkDown3", type number}, {"MarkDown4", type number}, {"MarkDown5", type number}, {"CPI", type number}, {"Unemployment", type number}, {"IsHoliday", type logical}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Fuel_Price", "Fuel Price"}})
in
    #"Renamed Columns"
