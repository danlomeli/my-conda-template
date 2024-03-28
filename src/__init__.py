# src/__init__.py

from prefect import Flow

# Import any necessary modules or packages here

def create_flow():
    # Define your Prefect flow here
    with Flow("my_flow") as flow:
        # Add tasks and dependencies
        pass

    return flow

# You can add any additional initialization code specific to the src module.