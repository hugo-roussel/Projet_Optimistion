function f=cout(x)
global OperationalCost ReserveCostPos ReserveCostNeg

f = x(1:12*24).*repmat(OperationalCost,24,1);