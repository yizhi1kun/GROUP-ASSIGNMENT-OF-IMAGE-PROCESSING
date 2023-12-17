function [sf, sn] = compute_sf_sn(imgref, imgdis)
    
    [m, n] = size(imgdis);
    s = min(m, n);
    Orig_ref = imresize(imgref, [s, s]);
    Orig_T_ref = dct2(Orig_ref);
    cutoff = round(0.5 * s);
    High_T_ref = fliplr(tril(fliplr(Orig_T_ref), cutoff));
    Low_T_ref = Orig_T_ref - High_T_ref;
    High_ref = idct2(High_T_ref);
    Low_ref = idct2(Low_T_ref);
    Orig = imresize(imgdis, [s, s]);
    Orig_T = dct2(Orig);
    cutoff = round(0.5 * s);
    High_T = fliplr(tril(fliplr(Orig_T), cutoff));
    Low_T = Orig_T - High_T;
    High = idct2(High_T);
    Low = idct2(Low_T);

    sf = msssim(uint8(Low_ref), uint8(Low));
    sn = entropy(uint8(High));
end


