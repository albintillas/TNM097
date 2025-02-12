function out=mysnr(in,noise)

% out=mysnr(in, noise);
%
% in is the original image
% noise is the difference between the original image and the reproduction
% (i.e. the halftoned image)
% out returns the SNR

out=10*log10(sum(in(:).^2)/sum(noise(:).^2));