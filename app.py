from flask import Flask, render_template, request, redirect
import psycopg2
from datetime import datetime

app = Flask(__name__)

# Konfiguracja połączenia z bazą danych
conn_params = {
    'dbname': 'logistics',
    'user': 'postgres',
    'password': 'Melon5carro7',
    'host': 'localhost',
    'port': '5432'
}

# Funkcja do połączenia z bazą danych
def get_db_connection():
    conn = psycopg2.connect(**conn_params)
    return conn

@app.route('/', methods=['GET', 'POST'])
def wprowadz_zlecenie():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == 'POST':
        customer = request.form['customer']
        sender = request.form['sender']
        receiver = request.form['receiver']
        goods = request.form['goods']
        weight = request.form['weight']
        
        # Wstawienie nowego rekordu do tabeli 'order'
        cur.execute("""
            INSERT INTO "order" (customer, weight, sender, receiver, goods)
            VALUES (%s, %s, %s, %s, %s)
        """, (customer, weight, sender, receiver, goods))
        conn.commit()
        return redirect('/')

    # Pobieranie danych do listy wyboru
    cur.execute('SELECT name, street, nr, city, postcode FROM customer')
    customers = cur.fetchall()

    cur.execute('SELECT name, street, nr, city, postcode FROM senders')
    senders = cur.fetchall()

    cur.execute('SELECT name, street, nr, city, postcode FROM receivers')
    receivers = cur.fetchall()

    cur.execute('SELECT name FROM goods')
    goods_list = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('form.html', customers=customers, senders=senders, receivers=receivers, goods_list=goods_list)

@app.route('/nowa-trasa', methods=['GET', 'POST'])
def nowa_trasa():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == 'POST':
        order_1 = request.form['order_1']
        order_2 = request.form['order_2']
        order_3 = request.form['order_3']
        truck = request.form['truck']

        # Wstawienie nowego rekordu do tabeli 'tour'
        cur.execute("""
            INSERT INTO tour (truck, order_1, order_2, order_3)
            VALUES (%s, %s, %s, %s)
        """, (truck, order_1, order_2, order_3))
        conn.commit()

        # Aktualizacja kolumny 'archive' na true dla wybranych zleceń
        cur.execute("""
            UPDATE "order" SET archive = true WHERE order_nr IN (%s, %s, %s)
        """, (order_1, order_2, order_3))
        conn.commit()

        return redirect('/nowa-trasa')

    # Pobieranie listy zleceń, gdzie archive nie jest true
    cur.execute("""
        SELECT order_nr, date, sender, receiver, goods, weight 
        FROM "order" 
        WHERE archive IS DISTINCT FROM true
    """)
    orders = cur.fetchall()

    # Pobieranie listy samochodów
    cur.execute("""
        SELECT lic_plate, capacity FROM trucks
    """)
    trucks = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('nowa_trasa.html', orders=orders, trucks=trucks)

from datetime import datetime

@app.route('/lista-tras', methods=['GET', 'POST'])
def lista_tras():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == 'POST':
        # Pobierz wartości zaznaczonego archiwum
        archive_values = request.form.getlist('archive')
        
        # Zaktualizuj kolumnę archive na true i ustaw datę dla zaznaczonych tras
        if archive_values:
            cur.execute("""
                UPDATE tour
                SET archive = true, date = NOW()
                WHERE tour_nr IN %s
            """, (tuple(archive_values),))
            conn.commit()
        return redirect('/lista-tras')

    # Pobierz trasy, gdzie archive = false lub archive IS NULL
    cur.execute("""
        SELECT tour_nr, truck, order_1, order_2, order_3, archive 
        FROM tour 
        WHERE archive = false OR archive IS NULL
    """)
    tours = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('lista_tras.html', tours=tours)

@app.route('/archiwum-zlecen', methods=['GET'])
def archiwum_zlecen():
    conn = get_db_connection()
    cur = conn.cursor()

    # Pobieranie zleceń, gdzie archive = true
    cur.execute("""
        SELECT order_nr, date, customer, sender, receiver, goods 
        FROM "order"
        WHERE archive = true
    """)
    archived_orders = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('archiwum_zlecen.html', archived_orders=archived_orders)

@app.route('/archiwum-tras', methods=['GET'])
def archiwum_tras():
    conn = get_db_connection()
    cur = conn.cursor()

    # Pobieranie tras, gdzie archive = true
    cur.execute("""
        SELECT tour_nr, date, order_1, order_2, order_3, truck
        FROM tour
        WHERE archive = true
    """)
    archived_tours = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('archiwum_tras.html', archived_tours=archived_tours)

if __name__ == '__main__':
    app.run(debug=True)
