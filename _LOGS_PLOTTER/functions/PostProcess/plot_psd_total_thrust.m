function [f, Pxx] = plot_psd_total_thrust(x, Fs, pp)
% plot_psd_total_thrust
% Computes and plots the Power Spectral Density (PSD) of the total thrust
% signal using Welch's method.
%
% Inputs:
%   x  - signal vector (total thrust) [N]
%   Fs - sampling frequency [Hz]
%   pp - plotting parameters struct
%
% Outputs:
%   f   - frequency vector [Hz]
%   Pxx - power spectral density [N^2/Hz]

  % Ensure column vector
  x = x(:);

  % Remove DC component
  x = x - mean(x);

  % Welch PSD parameters (reasonable defaults)
  nfft    = 2^nextpow2(min(length(x), 1024));
  window  = hann(nfft);
  noverlap = round(0.5 * nfft);

  % PSD computation
  [Pxx, f] = pwelch(x, window, noverlap, nfft, Fs);

  % Plot
  set(figure,'Color','white','WindowState','maximized')
  semilogy(f, Pxx, 'b-', 'LineWidth', 1.2)
  axis tight
  xlabel('Frequency [Hz]', ...
         'Interpreter','latex', ...
         'FontSize', pp.font_size)
  ylabel('Power spectral density of total thrust [N$^2$/Hz]', ...
         'Interpreter','latex', ...
         'FontSize', pp.font_size)
  title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
end
