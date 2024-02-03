############### BOILER-PLATE #########################################
PACKAGES=com.databricks:spark-xml_2.12:0.12.0
JARS=--jars jars/spark-xml_2.12-0.12.0.jar

export PYSPARK_DRIVER_PYTHON_OPT=
ifeq ($(NOTEBOOK), 1)
export PYSPARK_DRIVER_PYTHON_OPTS=notebook
endif

venv:
ifndef VIRTUAL_ENV
$(error VIRTUAL / CONDA ENV is not set - please activate environment)
endif
ifndef SPARK_HOME
$(error SPARK_HOME env variable not set)
endif
ifndef PYSPARK_DRIVER_PYTHON
$(error PYSPARK_DRIVER_PYTHON env variable not set)
endif
########### PUBLIC API ###########################################

deps: venv
	pip install -Ur requirements.txt

run: venv
	pyspark --packages $(PACKAGES) $(JARS) --driver-memory 4g --conf spark.driver.maxResultSize=2g
