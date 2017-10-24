import ballerina.net.jms;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    connectionFactoryType:jms:TYPE_QUEUE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
	    jms:ClientConnector jmsEP;
        map properties = {"initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                             "providerUrl":"tcp://localhost:61616",
                             "connectionFactoryName":"QueueConnectionFactory",
                             "connectionFactoryType":jms:TYPE_QUEUE
                         };

        jmsEP = create jms:ClientConnector(properties);
        jms:JMSMessage message2 = jms:createTextMessage(jmsEP);
        message2.setTextMessageContent("{\"WSO2\":\"Ballerina\"}");
        // jms:PERSISTENT_DELIVERY_MODE (default)
        message2.setDeliveryMode(jms:NON_PERSISTENT_DELIVERY_MODE);
        jmsEP.send("MyQueue2", message2);
    }
}
