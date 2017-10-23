import ballerina.net.jms;
import ballerina.lang.system;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryName:"TopicConnectionFactory",
    destination:"MyTopic",
    connectionFactoryType:jms:TYPE_TOPIC
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
	    system:println(request.getTextMessageContent());
    }
}
