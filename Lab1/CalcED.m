function Euc_Dist = CalcED(ref,est)

[L1, A1, B1] = xyz2lab(ref(1,:), ref(2,:), ref(3,:));
[L2, A2, B2] = xyz2lab(est(1,:), est(2,:), est(3,:));

Euc_Dist = sqrt((L1-L2).^2 + (A1-A2).^2 + (B1-B2).^2);

end