FROM tomsik68/xampp
MAINTAINER maxisoft

RUN curl -o db.sql https://raw.githubusercontent.com/maxisoft/m2test6/master/sql/db.sql
RUN cp db.sql db_test.sql
RUN sed -i -e "s/m2test6/m2test6-utest/g" db_test.sql

RUN echo "/opt/lampp/lampp start \n\
while  ! /opt/lampp/bin/mysql -e 'use m2test6' \n\
do \n\
    sleep 1 \n\
    /opt/lampp/bin/mysql < db.sql \n\
    /opt/lampp/bin/mysql < db_test.sql \n\
done \n\
/usr/bin/supervisord -n" > /startup.sh

CMD ["sh", "/startup.sh"]
