import ballerina.net.jms;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616?jms.redeliveryPolicy.maximumRedeliveries=0",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    connectionFactoryType:jms:TYPE_QUEUE,
    acknowledgementMode:jms:SESSION_TRANSACTED
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        //Process the message
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
            //abort;
        } failed {
            request.rollback();
	    } committed {
            request.commit();
	    }
    }
}
