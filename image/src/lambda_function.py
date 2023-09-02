import pandas as pd
from extracting.extracter import Extracter
from processing.processor import Processor
from loading.loader import Loader
import json

def lambda_handler(event, context):
    schedule = event['schedule']
    extractor = Extracter(f"https://github.com/trending?since={schedule}")
    dfrepo = extractor.get_repo_information()
    dfuser = extractor.get_user_information()
    repodf = pd.DataFrame(dfrepo)
    user = pd.DataFrame(dfuser)
    rawdf = pd.merge(repodf,user)
    rawdf["time_id"] = pd.to_datetime(rawdf["time_id"])
    processor = Processor(user,rawdf)
    userdf = processor.get_user_table()
    timedf = processor.get_time_table()
    repositorydf = processor.get_repository_table()
    # factdf = processor.get_fact_table()
    rankdf = processor.get_rank_table()
    repositorydf.fillna("unknown",inplace=True)
    userdf.fillna("unknown",inplace=True)
    loader = Loader()
    loader.load_user(userdf)
    loader.load_time(timedf)
    loader.load_repository(repositorydf)
    loader.load_rank(rankdf)
    loader.load_fact(repodf,userdf)
    loader.commit_data()

    return "Accomplished" 