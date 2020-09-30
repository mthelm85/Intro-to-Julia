using BenchmarkTools
using PyCall;

a = rand(10^7)

python_speed = @benchmark pybuiltin("sum")($a)
julia_speed = @benchmark sum($a)

using CSV
using DataFrames;

covid19_data = CSV.File("data/covid_19_data.csv") |> DataFrame
ces_data = CSV.File(download("https://download.bls.gov/pub/time.series/ce/ce.data.00a.TotalNonfarm.Employment"), normalizenames=true) |> DataFrame

using StatFiles

sas_data = load("data/cv87_0.sas7bdat") |> DataFrame
ces_data[2,4]
ces_data.year # or
ces_data[:, 2] # or
ces_data[:, :year]
ces_data[5, :]
sort(ces_data, :value, rev=true)
ces_data[1984 .< ces_data.year .< 1991, :]
groupby(ces_data, :year)
using Plots

ces_plot_data = ces_data[ces_data.series_id .== ces_data[1,1], :]

ces_plot = plot(ces_plot_data.value, legend=false, formatter=:plain)
ces_plot = plot(
    ces_plot_data.value,
    legend=false,
    formatter=:plain,
    xlabel="Period",
    ylabel="Value",
    title="CES Series CES0000000001"
)
ces_plot = plot(
    ces_plot_data.value[1:50:end],
    legend=false,
    formatter=:plain,
    xlabel="Period",
    ylabel="Value",
    title="CES Series CES0000000001",
    markershape=:diamond
)
function change_value(value)
    return value / 2 + 3
end
change_value(ces_data[1,:value])
function check_value(value, threshold)
    t = threshold * 1.5 * 75000
    if value > t
        return value
    else
        return t
    end
end
check_value(ces_data[1,:value], 0.9)