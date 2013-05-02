# source( 'rf.r' )

# produce a submission file
# you will still need to convert integers to floats ( x -> x.0 )

library( randomForest )

train_file = 'data/train.csv'
test_file = 'data/test.csv'
output_file = 'p.txt'

# setwd( '/path/to/project/dir' )

train = read.csv( train_file, header = F )
test = read.csv( test_file, header = F )

y_train = train[, 1]
x_train = train[, -1]

names(test) = names(x_train)

##

ntrees = 300

rf <- randomForest( x_train, as.factor( y_train ), ntree = ntrees, do.trace = 1 )
p <- predict( rf, test)

writeLines( as.character( p ), output_file )

