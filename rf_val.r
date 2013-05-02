# source( 'rf_val.r' )

# perform validation n_times

n_times = 20

library( randomForest )
library( caTools )

train_file = 'data/train.csv'
cat( "\n", train_file, "\n\n" )

data = read.csv( train_file, header = F )

# 90/10 fixed split
y_train = data[1:900, 1]
x_train = data[1:900, -1]

y_test = data[901:1000, 1]
x_test = data[901:1000, -1]

##

ntrees = 100
accs = c()

for ( i in 1:n_times ) {

	rf <- randomForest( x_train, as.factor( y_train ), ntree = ntrees ) 
	p <- predict( rf, x_test )

	accuracy = sum( p == y_test ) / length( y_test )
	cat( "accuracy:", accuracy, "\n" )
	
	accs = append( accs, accuracy )
}

cat ( "\n" )
cat ( "average accuracy:", mean( accs ), "\n" )
cat ( "median accuracy:", median( accs ), "\n" )


