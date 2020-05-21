<?php

namespace App\Controller;

use Cake\ORM\TableRegistry;

class CartsController extends AppController {

    public function initialize()
    {
        parent::initialize();
        $this->loadComponent('Paginator');
    }

    //view
    public function all()
    {
        $cartTable = TableRegistry::getTableLocator()->get('Carts');
        $query = $cartTable->find('all');
        $carts = $query->all()->toArray();
        $this->set('carts', $carts);
    }

    //rest
    public function index()
    {
        $carts = $this->Carts->find('all');
        $this->set([
            'carts' => $carts,
            '_serialize' => ['carts']
        ]);
    }

    //rest
    public function add()
    {
        $this->request->allowMethod(['post', 'put']);
        $cart = $this->Carts->newEntity($this->request->getData());
        if ($this->Carts->save($cart)) {
            $message = 'Saved';
        } else {
            $message = 'Error';
        }
        $this->set([
            'message' => $message,
            '_serialize' => ['message']
        ]);
    }

    //rest
    public function view($id = null) {
        $cart = $this->Carts->get($id);
        $this->set([
            'cart' => $cart,
            '_serialize' => ['cart']
        ]);
    }

    //rest
    public function delete($id)
    {
        $this->request->allowMethod(['delete']);
        $cart = $this->Carts->get($id);
        $message = 'Deleted';
        if (!$this->Carts->delete($cart)) {
            $message = 'Error';
        }
        $this->set([
            'message' => $message,
            '_serialize' => ['message']
        ]);
    }
}