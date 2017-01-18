sel = input('Choose a function.\n');
sel = round(sel);

if sel<1 || sel>10
    fprintf('See you.\n')
    return
end

img_name = uigetfile({'*.tif'}, 'Select picture');
input_img = im2single(imread(img_name));

if sel == 1
    fprintf('Please wait...\n')
    mask_size = 71;
    input_img(:, :, 1) = medfilt2(input_img(:, :, 1), [mask_size mask_size]);
    input_img(:, :, 2) = medfilt2(input_img(:, :, 2), [mask_size mask_size]);
    input_img(:, :, 3) = medfilt2(input_img(:, :, 3), [mask_size mask_size]);
    figure
    imshow(input_img(:, :, 1:3));
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step1.tif'));
elseif sel == 2
    fprintf('Please wait...\n')
    file_in = uigetfile({'*.tif'}, 'Select light');
    light = im2single(imread(file_in));
    input_img = (1-light + input_img).^30;
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step2.tif'));
elseif sel == 3
    fprintf('Please wait...\n')
    input_img = myfilt1(input_img, 50);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step3.tif'));
elseif sel == 4
    fprintf('Please wait...\n')
    mask = 1 - im2single(bwareafilt(logical(1-rgb2gray(input_img)), [0, 500]));
    input_img = 1-(1-input_img).* cat(3, mask, mask, mask);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step4.tif'));
elseif sel == 5
    fprintf('Please wait...\n')
    kernal = strel('disk', 6);
    input_img = imopen(input_img, kernal);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step5.tif'));
elseif sel == 6
    fprintf('Please wait...\n')
    len = 200;
    input_img = line_detect(rgb2gray(input_img), len);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), strcat(img_name(1:length(img_name)-4), '_step6.tif'));
elseif sel == 7
    fprintf('Please wait...\n')
    input_img = logical(1-input_img);
    fl = fopen('step8.in', 'w');
    fprintf(fl, '%d %d\n', size(input_img));
    fprintf(fl, '%d ', input_img);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), strcat(img_name(1:length(img_name)-4), '_step7.tif'));
elseif sel == 8 %choose5&6
    fprintf('Please wait...\n')
    file_in = uigetfile({'*.tif'}, 'Select light');
    line = im2single(imread(file_in));
    kernal = strel('disk', 10);
    line = imopen(line, kernal);
    input_img = 1-(1-input_img).*cat(3, line, line, line);
    A = 1-dlmread('step8.out');
    input_img = input_img.*cat(3, A, A, A);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img(:, :, 1:3)), strcat(img_name(1:length(img_name)-4), '_step8.tif'));
end