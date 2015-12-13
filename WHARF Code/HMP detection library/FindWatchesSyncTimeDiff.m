% -------------------------------------------------------------------------
% Author: Tiago Pimentel (dept. DIBRIS, University of Genova, ITALY)
%
% -------------------------------------------------------------------------
%
% FindWatchesSyncTimeDiff finds the time difference between two smart
% watches timestamp by using reference synchronous data. This data should
% be taken by starting both watches at, as preciselly as possible, the same
% time, and this time difference is used as reference to synchronize both
% watches in BuildWHARF and ValidateWHARF. This data should be placed in
% the DATA/SYNCHRONOUS/ folder, with right and left hand data named as, 
% respectively, XXXXX_Right.txt and XXXXX_Left.txt.

% Get files in SYNCHRONIZATION data folder
folder = 'Data\SYNCHRONIZATION\';
files = [dir([folder,'*_Left.txt'])';
         dir([folder,'*_Right.txt'])'];
% Get number of data entries. Number of left and right files is assumed to
% be the same
num_files = size(files, 2);
left_watch = 1;
right_watch = 2;

% Initialize delta time
delta_time = 0;
% Calculate delta time
for i=1:1:num_files
    for watch_index=1:1:2
        % Get timestamp data
        trial_file = fopen([folder files(watch_index, i).name],'r');
        trial_data = fscanf(trial_file,'a;%ld;%f;%f;%f\n',[4,inf]);
        trial_time(watch_index) = trial_data(1,1);
    end
    delta_time = delta_time + (trial_time(left_watch) - trial_time(right_watch))/num_files;
end

% Clear undesired variables
clear folder files num_files trial_file trial_data trial_time i watch_index

% Save delta time value
save delta_time_sync.mat