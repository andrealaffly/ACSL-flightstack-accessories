function [f, P1] = plot_single_sided_fft(x, Fs, pp)
% plot_single_sided_fft
% Computes and plots the single-sided amplitude spectrum of a signal.
%
% Inputs:
%   x  - signal vector
%   Fs - sampling frequency [Hz]
%
% Outputs:
%   f  - frequency vector [Hz]
%   P1 - single-sided amplitude spectrum

  % Ensure column vector
  x = x(:);

  % Remove DC component
  x = x - mean(x);

  % Signal length
  L = length(x);

  % FFT
  Y = fft(x);

  % Two-sided spectrum
  P2 = abs(Y / L);

  % Single-sided spectrum
  P1 = P2(1:floor(L/2) + 1);
  if L > 1
    P1(2:end-1) = 2 * P1(2:end-1);
  end

  % Frequency vector
  f = Fs * (0:floor(L/2)) / L;

  % Plot
  set(figure,'Color','white','WindowState','maximized')
  plot(f, P1, 'b-', 'LineWidth', 1.2)
  % grid on
  axis tight
  xlabel('Frequency [Hz]','interpreter','latex','fontsize',pp.font_size)
  ylabel('Amplitude of FFT of total thrust [N]','interpreter','latex','fontsize',pp.font_size)
  title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
end
