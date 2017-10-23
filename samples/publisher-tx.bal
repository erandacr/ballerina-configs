import ballerina.net.jms;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:jms:TYPE_QUEUE,
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    acknowledgementMode:jms:AUTO_ACKNOWLEDGE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        jms:ClientConnector jmsEP;
        map properties = {"initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                             "providerUrl":"tcp://localhost:61616",
                             "connectionFactoryName":"QueueConnectionFactory",
                             "connectionFactoryType":jms:TYPE_QUEUE,
                             "acknowledgementMode":jms:SESSION_TRANSACTED
                         };

        jmsEP = create jms:ClientConnector(properties);
        jms:JMSMessage message2 = jms:createTextMessage(jmsEP);
        message2.setTextMessageContent("{\"WSO2\":\"Ballerina\"}");
        transaction {
            jmsEP.send("MyQueue2", message2);
            jmsEP.send("MyQueue2", message2);
        }
    }
}
