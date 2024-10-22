package ru.pepsxx.hibernate.help.v010_collection;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class Main {
    public static void main(String[] args) {

        Configuration configuration = new Configuration()
                .addAnnotatedClass(CardCollection.class);

        try (SessionFactory sessionFactory = configuration.buildSessionFactory()) {
            Session session = sessionFactory.getCurrentSession();
            session.beginTransaction();

            CardCollection testCollectionsName = new CardCollection("TestCollectionsName");
            session.persist(testCollectionsName);

            session.getTransaction().commit();
        }

    }
}