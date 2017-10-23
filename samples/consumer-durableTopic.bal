import ballerina.net.jms;
import ballerina.lang.system;
import ballerina.doc;

@doc:Description{value : "Add the subscriptionId when connecting to a topic to create a durable topic subscription. clientId should be set if you are using any broker other than WSO2 MB "}
@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"topic",
    connectionFactoryName:"TopicConnectionFactory",
    destination:"MyTopic",
    subscriptionId:"mySub1",
    clientId:"jms-consumer-1"
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
	    system:println(request.getTextMessageContent());
    }
}
