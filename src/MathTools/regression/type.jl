"""

$(TYPEDEF)

Struct to save linear regression results

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct LinearRegressionResult
    "Regression results"
    LM

    "Coeffients for all X"
    COEF::Vector = coef(LM)
    "Confidence intervals of the coefficients"
    CONFINT::Matrix = confint(LM)
    "P values of each coefficient"
    P::Vector = coeftable(LM).cols[4]
    "Adjust R²"
    R²::Number = adjr²(LM)
    "Predicted Y with confidence interval"
    XY::DataFrame = (
        _df = DataFrame();
        _pred = predict(LM, LM.pp.X; interval=:confidence);
        for i in axes(LM.pp.X,2)
            _df[!,"X$(i)"] = LM.pp.X[:,i];
        end;
        _df[!,"Y"     ] = LM.rr.y;
        _df[!,"predY" ] = _pred.prediction;
        _df[!,"lowerY"] = _pred.lower[:,1];
        _df[!,"upperY"] = _pred.upper[:,1];
        _df)
end;
