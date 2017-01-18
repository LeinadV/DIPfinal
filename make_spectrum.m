function [ spectrum ] = make_spectrum( input_f )
    spectrum = log(1+abs(input_f));
    input_max = max(spectrum(:));
    spectrum = spectrum/input_max;
end