% Plotting roots of monic Littlewood polynomials (and monic polynomials with coefficients of 1 and other numbers)

N = 20; % degree of polynomials
other_no = -1; % second number between -1 and 1
bins_radius = 2;
bin_n = 1080;
bin_width = 2*bins_radius/bin_n;

% generate matrix of polynomial coefficients
x = [other_no; 1];
for i = 2:N,
  s = size(x,1);
  x = [[x, other_no*ones(s,1)]; [x, ones(s,1)]];
end
x = [ones(size(x,1),1), x]; % add column of ones

my_roots = zeros(2^N,N); % empty matrix of roots
for n = 1:2^N
    my_roots(n,:) = roots(x(n, :));
end

% put roots into long vectors
ans = real(my_roots);
reals = ans(:)';
ans = imag(my_roots);
imags = ans(:)';

points = [reals', imags']; % put long vectors into paired matrix
% remove entries with no imaginary part
have_imag_part = (points(:, 2) == 0);
points(have_imag_part, :) = [];

% plot roots
figure
scatter(reals,imags,1);

% density
edges = {(-bins_radius:bin_width:bins_radius-bin_width),(-bins_radius:bin_width:bins_radius-bin_width)}; 
heat = hist3(points, 'Edges', edges); % calculate density matrix
ptile = prctile(heat(:)',99); % caculate the 99th percentile
heat(heat > ptile) = ptile; % cap density matrix at 99th percentile
heat = 256*heat/max(max(heat)); % scale to be between 0 and 256

% make image of density
imwrite(heat,parula(256),'myimage.png')
