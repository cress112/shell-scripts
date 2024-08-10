import datetime
import subprocess
import json
import time
import os

### ================================================
### FUNCTIONS
### ================================================
def readjson(json_path: str) -> dict:
    with open(json_path) as f:
        d = json.load(f)
    return d

def get_diff_sec(hhmm_target: str) -> int:
    """

    Args:
        hhmm_in(str): 差を知りたい時刻, ex)"22:35"
        hhmm_target(str): 基準時刻
    Attributes:
        diff_sec(int): hhmm_target - hhmm_in に相当する秒数
    """
    now_date = datetime.datetime.strptime(datetime.datetime.now().strftime('%H:%M:%S'), '%H:%M:%S')
    target_date = datetime.datetime.strptime(hhmm_target, '%H:%M')
    return (target_date - now_date).seconds

def notify(title: str, message: str) -> None:
    """
    osascriptを使って通知を行う
    Args:
        title(str): 通知タイトル
        message(str): 通知本文
    Attributes:
        None
    """
    notice_arg = f"display notification \"{message}\" with title \"{title}\""
    subprocess.run(["osascript", "-e", notice_arg])

def run(config: dict) -> None:
    """
    実処理部分
    Args:
        config(dict): 動作内容を指定したdict
    Attributes:
        None
    """
    diff_sec = get_diff_sec(config["runtime"])
    time.sleep(diff_sec)
    notify(config["title"], config["message"])

### ================================================
### MAIN
### ================================================
if __name__=="__main__":
    # 環境変数取得
    SOURCEPATH = os.environ["SCRIPT_DIR"]
    
    config = readjson(SOURCEPATH + '/python-sources/.atrun-config.json')
    run(config)
