% run( 'sparse_filtering_extra_400.m' )

L1_size = 400

project_dir = '/path/to/project/dir'

train_file = 'data/orig/train.csv'
test_file = 'data/orig/test.csv'

output_train = 'data/sf/train_400_extra.csv'
output_test = 'data/sf/test_400_extra.csv'
output_weights = 'L1_extra.mat'					% save weights so you don't have to train the same thing again
	
extra_dir = '/path/to/extra/data/dir'
sf_dir = '/path/to/matlab/sparse/filtering/dir'

cd( project_dir )

train = csvread( train_file, 1, 0 );
test = csvread( test_file, 1, 0 );

cd( extra_dir )

load extra

y_train = train(:,1);
x_train = train(:,2:end);

x = [ x_train; test; data ];

train_end = size( train, 1 );
test_end = train_end + size( test, 1 );


cd( sf_dir )

startup

x = x';

% 1

tic
L1 = sparseFiltering( L1_size, x );
toc

x1 = feedForwardSF( L1, x );

% save

x1 = x1';
x1_train = x1(1:train_end,:);
x1_test = x1(train_end+1:test_end,:);

cd( project_dir )
csvwrite( output_train, [ y_train x1_train ] )
csvwrite( output_test, [ x1_test ] )

save( output_weights, 'L1' )







