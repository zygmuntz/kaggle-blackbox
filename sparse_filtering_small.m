% run( 'sparse_filtering_big.m' )

% run sparse filtering on blackbox train + test, without extra data

% modify these

project_dir = '/path/to/project/dir'

train_file = 'data/orig/train.csv'
test_file = 'data/orig/test.csv'
output_train = 'data/sf/train_100_80.csv'
output_test = 'data/sf/test_100_80.csv'
output_weights = 'L1_L2.mat'	% save weights so you don't have to train the same thing again

sf_dir = '/path/to/matlab/sparse/filtering/dir'

cd( project_dir )

% original data with headers
train = csvread( train_file, 1, 0 );
test = csvread( test_file, 1, 0 );

y_train = train(:,1);
x_train = train(:,2:end);

x = [ x_train; test ];

train_end = size( train, 1 );

%%%

cd( sf_dir )

startup

% examples in columns instead of rows
x = x';

% don't
% x = bsxfun( @minus, x, mean( x ));

% layer 1

L1_size = 100; 
tic
L1 = sparseFiltering( L1_size, x );		% this will take some time
toc
x1 = feedForwardSF( L1, x );

% don't
% x1 = bsxfun( @minus, x1, mean( x1 ));

% layer 2

L2_size = 80;
tic
L2 = sparseFiltering( L2_size, x1 );
toc
x2 = feedForwardSF( L2, x1 );

% save

x2 = x2';
x2_train = x2(1:train_end,:);
x2_test = x2(train_end+1:end,:);

cd( project_dir )

csvwrite( output_train, [ y_train x2_train ] )
csvwrite( output_test, [ x2_test ] )
save( output_weights, 'L1', 'L2' )









