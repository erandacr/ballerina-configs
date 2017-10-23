import ballerina.net.jms;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    connectionFactoryType:jms:TYPE_QUEUE,
    acknowledgementMode:jms:AUTO_ACKNOWLEDGE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        //Process the message
	    jms:ClientConnector jmsEP;
        map properties = {   "initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                             "providerUrl":"tcp://localhost:61616",
                             "connectionFactoryName":"QueueConnectionFactory",
                             "connectionCount":"4",
                             "sessionCount":"7",
                             "connectionFactoryType":jms:TYPE_QUEUE
    };

        jmsEP = create jms:ClientConnector(properties);
        jms:JMSMessage message2 = jms:createTextMessage(jmsEP);
        message2.setTextMessageContent("{\"WSO2\":\"Ballerina\"}");
        jmsEP.send("MyQueue2", message2);
    }
}
