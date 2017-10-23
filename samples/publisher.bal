import ballerina.net.jms;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"queue",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    acknowledgementMode:jms:AUTO_ACKNOWLEDGE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        //Process the message
	    jms:ClientConnector jmsEP;
        map properties = {  "initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                            "providerUrl":"tcp://localhost:61616",
                            "connectionFactoryName":"QueueConnectionFactory",
                            "connectionFactoryType":"queue",
                            "connectionCount":"4",
                            "sessionCount":"7"
                         };

        jmsEP = create jms:ClientConnector(properties);
        jms:JMSMessage message2 = jms:createTextMessage(jmsEP);
        message2.setTextMessageContent("{\"WSO2\":\"Ballerina\"}");
        jmsEP.send("MyQueue2", message2);
    }
}
