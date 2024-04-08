import argparse
import json
import requests
from bs4 import BeautifulSoup

def fetch_staff_info(url):
    # HTMLを取得する
    response = requests.get(url)
    html_doc = response.text

    # HTMLをパースする
    soup = BeautifulSoup(html_doc, 'html.parser')

    # スタッフ情報を格納する<div class="gBox">を取得
    staff_divs = soup.find_all('div', class_='gBox')

    json = {}
    json["staffs"] = []
    staff_data = json["staffs"]

    # 各スタッフの情報を抽出してJSONデータに追加
    for staff_div in staff_divs:
        if not staff_div.find('a'):
            continue

        staff_id = staff_div.find('a')['href'].split('=')[1]

        # 名前と年齢を抽出
        name_age = staff_div.find('td', class_='name').get_text(strip=True)
        name = name_age.split('(')[0]
        age = name_age.split('(')[1].split(')')[0]

        # 3サイズを抽出
        size = staff_div.find('span', class_='size').get_text(strip=True)

        # タイプを抽出
        type_span = staff_div.find('span', class_='type')
        if type_span:
            staff_type = type_span.get_text(strip=True).replace('Type：', '')
        else:
            staff_type = ''

        # 可能オプションを抽出
        op_span = staff_div.find('span', class_='op')
        if op_span:
            op = op_span.get_text(strip=True).replace('可OP：', '')
        else:
            op = ''

        # 出勤時間を抽出
        syukkin = staff_div.find('td', class_='syukkin').find('span').get_text(strip=True)

        staff_data.append({
            'id': staff_id,
            'name': name,
            'age': age,
            'size': size,
            'type': staff_type,
            'op': op,
            'syukkin': syukkin
        })

    return json

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Fetch and parse staff information from a given URL.')
    parser.add_argument('url', type=str, help='URL of the staff information page')
    args = parser.parse_args()

    staff_data = fetch_staff_info(args.url)
    print(json.dumps(staff_data, ensure_ascii=False, indent=2))