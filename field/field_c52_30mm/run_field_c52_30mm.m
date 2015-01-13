clear; clf;

fem_root = '/luscinia/nl91/matlab/fem';
addpath(fullfile(fem_root, 'field'));
addpath /luscinia/nl91/matlab/Field_II/
field2dyna('nodes.dyn', 0.45, 2.8, [0 0 0.03], 2.36, 'c52', 'gaussian')