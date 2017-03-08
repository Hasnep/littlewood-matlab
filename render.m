function render(image_name, points, plot_centre, plot_scale, image_size)
% Create a representation of a matrix of points

% check what type of output required
if (strcmp(image_name, 'scatter'))
    % plot points on scatter plot
    scatter(points(1), points(2), 1);
else
    
    % calculate edges of bins
    image_ratio = image_size(2)/image_size(1);
    bin_points_x = linspace(-2 * plot_scale^-1, 2 * plot_scale^-1 ,image_size(1) + 1) + plot_centre(1);
    bin_points_y = linspace(-2 * plot_scale^-1 * image_ratio, 2 * plot_scale^-1 * image_ratio, image_size(2) + 1) - plot_centre(2);
    bin_points_x(image_size(1)) = [];
    bin_points_y(image_size(2)) = [];
    
    % calculate density of points
    density = hist3(points, 'Edges', {bin_points_x, bin_points_y}); % calculate density matrix
    ptile = prctile(density(:)', 99); % caculate the 99th percentile of density matrix
    density(density > ptile) = ptile; % cap density matrix at 99th percentile
    density = 256 * density/max(max(density)); % scale to be between 0 and 256
    
    % make image of density
    if (strcmp(image_name, 'density'))
        imagesc(density');
    else
        imwrite(density', parula(256), strcat(image_name, '.png'));
    end
end
end