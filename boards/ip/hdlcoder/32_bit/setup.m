%% Simulation
fs = 160e6;
n_blocks = 1;

%% LDPC Code Parameters
k = 80;
K = k/8;
n = 160;

%% Random Number Generator
aximm_enable = 1;
aximm_bits = n_blocks * k;
aximm_reset = 0;
generator_polynomial = '''z^13 + z^12 + z^11 + z^8 + 1''';

%% Encoder Ctrl
aximm_ctrl_word_enc = 0;
aximm_length_enc = k;
aximm_load_enc = 1;

%% Encoder/Decoder
parity = readmatrix('ldpc_codes/docsis_init_ranging_parity.csv');
parity_sparse = sparse(parity);

%% AWGN Channel
P_avg = 10;
snr = 40;
noise_var = P_avg / 10^(snr/10);

aximm_noise_std = sqrt(noise_var);
aximm_awgn_reset = 0;

%% Soft Demodulation
d = sqrt(-2*log([0:1/4095:1]));
d(1) = 6;
llr_scale = 7.75/7.75;

aximm_llr_scale = (1/noise_var) * llr_scale;
aximm_llr_mag_reset = 0;

%% Decoder Ctrl
aximm_ctrl_word_dec = 0;
aximm_length_dec = n;
aximm_load_dec = 1;

%% BER
aximm_bit_count_reset = 0;
aximm_length = k * n_blocks;


T = ((K*n_blocks))/fs + 70/fs;