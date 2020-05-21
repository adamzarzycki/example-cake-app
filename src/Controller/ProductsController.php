<?php

namespace App\Controller;

use Cake\ORM\TableRegistry;

class ProductsController extends AppController {

    public $paginate = [
        'limit' => 3,
        'order' => [
            'Products.id' => 'asc'
        ]
    ];

    public function initialize()
    {
        parent::initialize();
        $this->loadComponent('Paginator');
    }

    public function all()
    {
        $productTable = TableRegistry::getTableLocator()->get('Products');
        $query = $productTable->find('all');
        $products = $query->all()->toArray();
        $this->set('products', $products);
    }

    //rest
    public function index()
    {
        $products = $this->Products->find('all');
        $this->set([
            'products' => $this->paginate($products),
            '_serialize' => ['products']
        ]);
    }

    //rest
    public function view($id = null) {
        $product = $this->Products->get($id);
        $this->set([
            'product' => $product,
            '_serialize' => ['product']
        ]);
    }

    //rest
    public function add()
    {
        $this->request->allowMethod(['post', 'put']);
        $product = $this->Products->newEntity($this->request->getData());
        if ($err = $product->errors()) {
            $message = array_values(array_pop($err))[0];
        } else {
            if ($this->Products->save($product)) {
                $message = 'Saved';
            } else {
                $message = 'Error';
            }
        }
        $this->set([
            'message' => $message,
            'product' => $product,
            '_serialize' => ['message', 'product']
        ]);
    }

    //rest
    public function edit($id)
    {
        $this->request->allowMethod(['patch', 'post', 'put']);
        $product = $this->Products->get($id);
        $product = $this->Products->patchEntity($product, $this->request->getData());
        if ($this->Products->save($product)) {
            $message = 'Saved';
        } else {
            $message = 'Error';
        }
        $this->set([
            'message' => $message,
            '_serialize' => ['message']
        ]);
    }

    //json
    public function delete($id)
    {
        $this->request->allowMethod(['delete']);
        $product = $this->Products->get($id);
        $message = 'Deleted';
        if (!$this->Products->delete($product)) {
            $message = 'Error';
        }
        $this->set([
            'message' => $message,
            '_serialize' => ['message']
        ]);
    }

}
