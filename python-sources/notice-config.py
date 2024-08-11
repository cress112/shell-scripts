"""
    シェルからdl設定を処理する用
    ただただyt叩くなら、直でjson編集してね
"""

import os
import json
import argparse

def readjson(json_path: str) -> dict:
    with open(json_path) as f:
        d = json.load(f)
    return d


def writejson(json_path: str, content: dict) -> None:
    with open(json_path, 'w') as f:
        json.dump(content, f, indent=4)


class DlConfig(argparse.ArgumentParser):
    def __init__(self):# オプション引数の設定
        super().__init__(description='atrun config')
        self.add_argument('--runtime',
                          type=str,
                          help='(str) Time to notify, default: None',
                          default=None)
        self.add_argument('--title',
                          type=str,
                          help='(str) Title of Notice, default: yt_720p30fps',
                          default=None)
        self.add_argument('--message',
                          type=str,
                          help='(int) Message of notice, default: 1',
                          default=None)
        self.args = self.parse_args()


    def setConfig(self, json_path) -> None:# configをjsonに書き出し
        data = {
            "runtime": self.args.runtime,
            "title": self.args.title,
            "message": self.args.message,
        }
        writejson(json_path, data)


if __name__=='__main__':
    # 環境変数取得
    SOURCEPATH = os.environ["SCRIPT_DIR"]

    # オプション引数を処理
    Parser = DlConfig()
    Parser.setConfig(SOURCEPATH + '/python-sources/.notice-config.json')
