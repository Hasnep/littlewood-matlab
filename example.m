% An exmaple of finding and plotting the roots of a set of Littlewood polynomials

% find roots
polynomial_order = 10;
other_no = -1;
points = find_roots(polynomial_order, other_no);

% render
image_name = 'littlewood';
plot_centre = [0, 0];
plot_scale = 1;
image_size = [5000, 5000];
render(image_name, points, plot_centre, plot_scale, image_size);
