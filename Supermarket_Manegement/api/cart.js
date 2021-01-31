const app = require( "express" )();
const server = require( "http" ).Server( app );
const bodyParser = require( "body-parser" );
const Datastore = require( "nedb" );
const async = require( "async" );

app.use( bodyParser.json() );

module.exports = app;

 
let cartDB = new Datastore( {
    filename: "cart.db",
    autoload: true
} );


cartDB.ensureIndex({ fieldName: '_id', unique: true });


app.get( "/", function ( req, res ) {
    res.send( "Cart API" );
} );


app.get( "/cart/:cartID", function ( req, res ) {
    if ( !req.params.cartID ) {
        res.status( 500 ).send( "ID field is required." );
    } else {
        cartDB.findOne( {
            _id: req.params.cartID
        }, function ( err, cart) {
            res.send( cart);
        } );
    }
} );

 
app.get( "/all", function ( req, res ) {
    cartDB.find( {}, function ( err, docs ) {
        res.send( docs );
    } );
} );

 
app.post( "/cart", function ( req, res ) {
    var newCart = req.body;
    cartDB.insert(  newCart, function ( err, cart ) {
        if ( err ) res.status( 500 ).send( err );
        else res.sendStatus( 200 );
    } );
} );




app.delete( "/cart/:cartID", function ( req, res ) {
    cartDB.remove( {
        _id: req.params.cartID
    }, function ( err, numRemoved ) {
        if ( err ) res.status( 500 ).send( err );
        else res.sendStatus( 200 );
    } );
} );
 

 
app.put( "/cart", function ( req, res ) {
    let cartID = req.body._id;

    customerDB.update( {
        _id: cartID
    }, req.body, {}, function (
        err,
        numReplaced,
        cart
    ) {
        if ( err ) res.status( 500 ).send( err );
        else res.sendStatus( 200 );
    } );
});



 