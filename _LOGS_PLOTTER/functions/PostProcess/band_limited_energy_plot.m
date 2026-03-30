function band_limited_energy_plot(x, Fs, pp, bands)
% band_limited_energy_plot
% Computes band-limited spectral energy of a signal and plots as a bar graph.
%
% Inputs:
%   x     - signal vector [N]
%   Fs    - sampling frequency [Hz]
%   pp    - struct with plotting parameters (pp.font_size, pp.font_size_title, pp.folder_controller)
%   bands - optional Nx2 array of frequency bands [Hz]; each row = [f_low, f_high]
%
% Example bands: [0 5; 5 10; 10 20; 20 50];
%
% Uses Welch PSD internally

  if nargin < 4
      bands = [0 1; 1 5; 5 10; 10 20; 20 50]; % default example bands
  end

  % Ensure column vector
  x = x(:);

  % Remove DC component
  x = x - mean(x);

  % Compute PSD using Welch
  nfft     = 2^nextpow2(min(length(x), 1024));
  window   = hann(nfft);
  noverlap = round(0.5 * nfft);
  [Pxx, f] = pwelch(x, window, noverlap, nfft, Fs);

  % Compute energy in each band
  band_energy = zeros(size(bands,1),1);
  for i = 1:size(bands,1)
      idx = f >= bands(i,1) & f < bands(i,2);
      band_energy(i) = trapz(f(idx), Pxx(idx));
  end

  % Plot bar graph
  set(figure,'Color','white','WindowState','maximized')
  bar(band_energy, 'FaceColor', [0.2 0.6 0.8])
  grid on
  xticks(1:size(bands,1))
  xticklabels(arrayfun(@(i) sprintf('%g-%g', bands(i,1), bands(i,2)), 1:size(bands,1), 'UniformOutput', false))
  xlabel('Frequency Band [Hz]', 'Interpreter','latex', 'FontSize', pp.font_size)
  ylabel('Spectral Energy [N$^2$]', 'Interpreter','latex', 'FontSize', pp.font_size)
  title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
end
