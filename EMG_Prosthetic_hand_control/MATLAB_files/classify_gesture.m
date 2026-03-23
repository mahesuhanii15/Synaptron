function gesture = classify_gesture(f)

A1 = f(1);
A2 = f(2);
A3 = f(3);

TH = 0.15;

S1 = A1/(A2+A3+0.01);
S2 = A2/(A1+A3+0.01);
S3 = A3/(A1+A2+0.01);

if A1 < TH && A2 < TH && A3 < TH
    gesture = 0;
elseif S1 > 1.2
    gesture = 1;
elseif S2 > 1.2
    gesture = 2;
elseif S3 > 1.2
    gesture = 3;
else
    gesture = 0;
end

end