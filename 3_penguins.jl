using DataFrames
import DataFrames as jd
using CSV
using Statistics
using StatsPlots
import MLJ as ml
using MLJ
using Printf

# let's start with a familiar dataset, the penguins
filename = "data/penguins.csv"

# Julias pandas equivalent is the DataFrames library. Main difference it is way faster :)
df = jd.DataFrame(CSV.File(filename))
target = df.Species
jd.describe(df, :nmissing)

# note how many missing values we have in comments, lets drop the complete column, and drop the missing values next
df = jd.select(df, Not(:Comments))
jd.dropmissing!(df, disallowmissing=true)
jd.describe(df, :nmissing)

# While we could work with the categories, it's a bit simpler to focus on the floating point data for now.
function normalize(col)
	μ = Statistics.mean(col)
	σ = Statistics.std(col)
	(col .- μ) / σ
end

function process(df)
        floatcols = names(df, Float64)
        label = jd.select(df, :Species)
        normalized = jd.transform(df, floatcols .=> normalize .=> floatcols)
        normalized = jd.select(normalized, floatcols)
        data = jd.hcat(label, normalized)
        jd.transform!(data, :Species => ml.categorical => :Species)
end
df = process(df)
df

# Let's visualize the data
StatsPlots.density(df[!, 2], group=df.Species)
StatsPlots.groupedhist(df[!, 2], group=df.Species)

x1 = 2
x2 = 3
xlab = names(df)[x1]
ylab = names(df)[x2]
Plots.scatter(df[!, x1], floatdata[!, x2], group=df.Species, alpha=0.5, xlabel=xlab, ylabel=ylab, title="Penguin Data", legend = :outerbottom)

#=
Now, let's try some machine learning
First, I would like to point out that implementing algorithms in Julia can be done quite elegantly. Take for example Linear regression (see https://github.com/mossr/BeautifulAlgorithms.jl for more examples)
=#
function linear_regression(X, y)
        𝐗 =  [ones(size(y)) X]
        θ = 𝐗 \ y
        @printf("Estimated parameters (intercept, slope): %.4f, %.4f\n", θ[1], θ[2])
        return x -> [1;x]'θ
end

# test with random data
n=100
X = rand(n) * 10
slope = 2.0
intercept = 3.0
# note the broadcasting
y = slope .* X .+ intercept + 0.5 * randn(n)
model = linear_regression(X, y);
y_pred = [model(xi) for xi in X]
scatter(X, y, label="True values", xlabel="X", ylabel="y", title="True vs Predicted Values")

#=
Ok, after this basic intro, lets try the MLJ library for the penguins data
First, lets check the schema, and split data and labels
=#
ml.schema(df)
y, X = ml.unpack(df, ==(:Species))
typeof(y)
typeof(X)
size(X)

#=
The first question now is; what are available models?
Interestingly, we can use the `models` function to get a list of all available models
give this specific schema of X and y. Note that it matters that our y is a categorical variable,
and not simply a string!
=#
possible_models = ml.models(ml.matching(X,y))
possible_models[end]

#= good, that are 54 models.
Let's assume we pick the XGBoost model, which is the last model
to determine which package provides the MLJ interface you call load_path
=#
ml.load_path("XGBoostClassifier", pkg="XGBoost")
# the required interface between MLJ and XGBoost is provided by MLJXGBoostInterface

XGBoostClassifier = @load XGBoostClassifier pkg=XGBoost
model = XGBoostClassifier()

# The easiest way to evaluate a model is to use the evaluate function
result = ml.evaluate(model, X, y, resampling=ml.CV(shuffle=true, nfolds=5),
        measures=[ml.accuracy, ml.multiclass_f1score, ml.ConfusionMatrix()])
