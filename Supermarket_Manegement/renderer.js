require('./assets/js/pos.js');
require('./assets/js/product-filter.js');
require('print-js');

const clientId = 'mqttjs_' + Math.random().toString(16).substr(2, 8)

const host = 'mqtt://broker.emqx.io:1883'

const options = {
  keepalive: 30,
  clientId: clientId,
  protocolId: 'MQTT',
  protocolVersion: 4,
  clean: true,
  reconnectPeriod: 1000,
  connectTimeout: 30 * 1000,
  will: {
    topic: 'WillMsg',
    payload: 'Connection Closed abnormally..!',
    qos: 0,
    retain: false
  },
  rejectUnauthorized: false
}

// Information about the mqtt module is available
console.log(mqtt)

console.log('connecting mqtt client')
const client = mqtt.connect(host, options)

client.on('error', (err) => {
  console.log('Connection error: ', err)
  client.end()
})

client.on('reconnect', () => {
  console.log('Reconnecting...')
})

var bill;
var state;
var Final_Bill_Dispaly;

client.on('connect', () => {
  console.log('Client connected:' + clientId)
  client.subscribe('testtopic/Final_Bill_Dispaly', {
    qos: 0
  })
  client.subscribe('desktop/Cart_01/bill', {
    qos: 0
  })
  client.subscribe('desktop/Cart_01/state', {
    qos: 0
  })

  client.publish('testtopic/Final_Bill_Dispaly', 'Rs 500', {
    qos: 0,
    retain: false
  })

  



})

client.on('message', (topic, message, packet) => {
  if (topic === 'testtopic/Final_Bill_Dispaly') {
    Final_Bill_Dispaly = message.toString();
    
  }

  if (topic === 'desktop/Cart_01/bill') {
    bill = message.toString();
    
  }

  if (topic === 'desktop/Cart_01/state') {
    state =message.toString();
  }
  if (state || bill || Final_Bill_Dispaly) {
    //do database update or print
    console.log("----");
    console.log("bill: %s", bill);
    console.log("----");
    console.log("state: %s", state);
    console.log("----");
    console.log("Final_Bill_Dispaly: %s", Final_Bill_Dispaly);
    //reset to undefined for next time
    bill = undefined;
    state = undefined;
    Final_Bill_Dispaly=undefined;
 }
 //console.log('Received Message: ' + message.toString() + '\nOn topic: ' + topic)
 
})
