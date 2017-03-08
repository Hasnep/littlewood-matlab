image_name = 'littlewood';
n_frames = 50;
polynomial_order = 20;
other_no = [-1, -1];
plot_centre = [[0, 0], [0, 0]];
plot_scale = [1, 5];
image_size = [1000, 1000];

other_no = linspace(other_no(1), other_no(2), n_frames);
plot_x = linspace(plot_centre(1), plot_centre(3), n_frames);
plot_y = linspace(plot_centre(2), plot_centre(4), n_frames);
plot_scale = linspace(plot_scale(1), plot_scale(2), n_frames);

%% calculating roots
constant_other_no = (other_no(1) == other_no(n_frames));
if (constant_other_no)
    cur_points = find_roots(polynomial_order, other_no(1));
else
    points = cell(1, n_frames);
for n = 1:n_frames
    points{n} = find_roots(polynomial_order, other_no(n));
    disp(strcat('finding roots: ', num2str(round(100*(n/n_frames))), '%'));
end
end

disp('DONE FINDING ROOTS');
load gong.mat;
sound(y/5, 8 * Fs);

%% rendering
for cur_frame = 1:n_frames;
    cur_plot_x = plot_x(cur_frame);
    cur_plot_y = plot_y(cur_frame);
    cur_plot_scale = plot_scale(cur_frame);
    
    if (~constant_other_no)
        cur_points = points{cur_frame};
    end
    
    str_zeros = '';
    for n = 1:(5 - numel(num2str(cur_frame)))
        str_zeros = strcat(str_zeros, num2str(0));
    end
    
    render(strcat(image_name, str_zeros, num2str(cur_frame)), cur_points, [cur_plot_x, cur_plot_y], cur_plot_scale, image_size)
    disp(strcat('rendering: ', num2str(round(100*(cur_frame/n_frames))), '%'));
end

disp('DONE RENDERING');
load gong.mat;
sound(y, 3 * Fs);