function points = find_roots(polynomial_order, other_no)
% Finding roots of N-th degree monic Littlewood polynomials

% determine the number of points that will be calculated
n_points = 2^polynomial_order;

% generate matrix of polynomial coefficients
coeffs = [other_no; 1];
for n = 2:polynomial_order,
    s = size(coeffs,1);
    coeffs = [[coeffs, other_no * ones(s,1)]; [coeffs, ones(s,1)]];
end
coeffs = [ones(n_points,1), coeffs]; % add column of ones for leading coefficients

% calculate the roots of each polynomial
my_roots = zeros(n_points,polynomial_order); % create empty matrix of roots
for n = 1:n_points
    my_roots(n,:) = roots(coeffs(n, :)); % calculate roots of polynomial with 1 as leading coefficient
end

% put roots into long vectors
real_parts = reshape(real(my_roots), polynomial_order * n_points, 1);
imag_parts = reshape(imag(my_roots), polynomial_order * n_points, 1);

% prepare for a density plot
points = [real_parts, imag_parts]; % put long vectors into paired matrix
points((imag_parts == 0), :) = []; % remove roots with 0 imaginary part
end