FROM python:3.12

ENV AIRFLOW_HOME=/usr/local/airflow

ENV AIRFLOW__CORE__DAGS_FOLDER=/usr/local/airflow/dags 
ENV AIRFLOW__CORE__PLUGINS_FOLDER=/usr/local/airflow/plugins

ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
ENV AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://postgres:password@postgres:5432/airflow"

ENV AIRFLOW__CORE__AUTH_MANAGER=airflow.providers.fab.auth_manager.fab_auth_manager.FabAuthManager

ENV AIRFLOW__CORE__LOAD_EXAMPLES=False

# Добавить ключ шифрования чувствительных данных.
ENV AIRFLOW__CORE__FERNET_KEY="key"

RUN pip install --upgrade pip
RUN pip install apache-airflow[postgres]
RUN pip install airflow-code-editor black fs-s3fs fs-gcsfs flask_appbuilder apache-airflow-providers-fab

RUN mkdir /project
COPY scripts/ /project/scripts/
RUN chmod +x /project/scripts/init.sh

ENTRYPOINT ["/project/scripts/init.sh"]