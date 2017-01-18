sel = input('Choose a function.\n');
sel = round(sel);

if sel<1 || sel>10
    fprintf('See you.\n')
    return
end

file_in = uigetfile({'*.tif'}, 'Select picture');
input_img = im2single(imread(file_in));

if sel == 1
    fprintf('Please wait...\n')
    %input_img = intensity(input_img);
    %imwrite(im2uint8(input_img), 'test2_mono.tif');
    %input_img = histEqualization(im2uint8(input_img));
    %input_img = im2single(input_img);
    %mask = zeros(5, 5)+1/25;
    %input_img = spatialFiltering(input_img, mask);
    mask_size = 71;
    img_filt = ordfilt2(input_img, round(mask_size^2/2), ones(mask_size, mask_size));
    %input_img = edge(input_img, 'Sobel');
    %input_img = threshold(input_img);
    figure
    imshow(img_filt);
    imwrite(im2uint8(img_filt), 'test2_step1.tif');
%     input_img_f = fftshift(fft2(input_img));
%     figure
%     imshow(make_spectrum(input_img_f));
elseif sel == 2
    fprintf('Please wait...\n')
    file_in = uigetfile({'*.tif'}, 'Select light');
    light = im2single(imread(file_in));
    input_img = (1-light + input_img).^30;
    %input_img = histEqualization(im2uint8(input_img));
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step2.tif');
elseif sel == 3
    fprintf('Please wait...\n')
    %input_img = threshold(input_img);
    %kernal = [0, 1, 0; 1, 1, 1; 0, 1, 0];
    %kernal = strel('disk', 8);
    %input_img = imclose(imopen(input_img, kernal), kernal);
    %input_img = imopen(input_img, kernal);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step3.tif');
elseif sel == 4
    fprintf('Please wait...\n')
    %kernal = strel('line', 25, 0);
    %input_img = imdilate(input_img, kernal);
    %kernal = strel('disk', 10);
    %input_img = imerode(input_img, kernal);
    input_img = myfilt1(input_img, 50);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step4.tif');
elseif sel == 5
    fprintf('Please wait...\n')
    %kernal = strel('disk', 12);
    %input_img = imopen(input_img, kernal);
    mask = 1 - im2single(bwareafilt(logical(1-input_img), [0, 500]));
    input_img = 1-(1-input_img).*mask;
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step5.tif');
elseif sel == 6
    fprintf('Please wait...\n')
    %input_img = threshold(input_img);
    kernal = strel('disk', 6);
    input_img = imopen(input_img, kernal);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step6.tif');
elseif sel == 7
    fprintf('Please wait...\n')
    len = 200;
    input_img = line_detect(input_img, len);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step7.tif');
elseif sel == 8
    fprintf('Please wait...\n')
    %left to right
    %if find start point, record, search right
    %fill zero to all passed point
    %find end point, record
    %draw a line on output
    input_img = logical(1-input_img);
    fl = fopen('step8.in', 'w');
    fprintf(fl, '%d %d\n', size(input_img));
    fprintf(fl, '%d ', input_img);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step8.tif');
elseif sel == 9
    fprintf('Please wait...\n')
    file_in = uigetfile({'*.tif'}, 'Select light');
    line = im2single(imread(file_in));
    kernal = strel('disk', 10);
    line = imopen(line, kernal);
    input_img = 1-(1-input_img).*line;
    %fileID = fopen('step8.out','r');
    %formatSpec = '%d';
    A = 1-dlmread('step8.out');
    input_img = input_img.*A;
    %A = fscanf(fileID,formatSpec);
    figure
    imshow(input_img);
    imwrite(im2uint8(input_img), 'test2_step9.tif');
end
