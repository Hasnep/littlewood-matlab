% Plotting roots of monic Littlewood polynomials (and monic polynomials with coefficients of 1 and other numbers)

% editable parameters
N = 20; % degree of polynomials
other_no = -1; % second number between -1 and 1
plot_radius = 2; % radius from centre to plot points
image_size = 1080; % width of image to export

% calculate the number of points that will be calculated
n_points = 2^N;

% generate matrix of polynomial coefficients
coeffs = [other_no; 1];
for n = 2:N,
    s = size(coeffs,1);
    coeffs = [[coeffs, other_no * ones(s,1)]; [coeffs, ones(s,1)]];
end
coeffs = [ones(n_points,1), coeffs]; % add column of ones for leading coefficients


my_roots = zeros(n_points,N); % create empty matrix of roots
for n = 1:n_points
    my_roots(n,:) = roots(coeffs(n, :)); % calculate roots of polynomial with 1 as leading coefficient
end

% put roots into long vectors
real_parts = reshape(real(my_roots),N*n_points,1);
imag_parts = reshape(imag(my_roots),N*n_points,1);
points = [real_parts, imag_parts]; % put long vectors into paired matrix

% remove roots with 0 imaginary part
points((imag_parts == 0), :) = [];

% plot roots
scatter(points(:,1), points(:,2), 1);

% density plot
bin_width = 2 * plot_radius/image_size;
bin_points = -plot_radius : bin_width : plot_radius-bin_width; % create the edge points of the bins for the histogram
edges = {bin_points, bin_points};
density = hist3(points, 'Edges', edges); % calculate density matrix
ptile = prctile(density(:)', 99); % caculate the 99th percentile of density matrix
density(density > ptile) = ptile; % cap density matrix at 99th percentile
density = 256 * density/max(max(density)); % scale to be between 0 and 256

% make image of density
imagesc(density');
imwrite(density', parula(256), 'littlewood.png');
