<nav class="mt-2">
  <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
    <!-- Add icons to the links using the .nav-icon class
         with font-awesome or any other icon font library -->
    <li class="nav-item">
      <a href="{base_url()}" class="nav-link {if $smarty.server.REQUEST_URI=='/globalpower/'}active{/if}">
        <i class="nav-icon fas fa-home"></i>
        <p>
          Dashboard
        </p>
      </a>
    </li>
    <li class="nav-item has-treeview {if $smarty.server.REQUEST_URI|strpos:'/transaksi' !== false}menu-open{/if}">
      <a href="#" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/transaksi' !== false}active{/if}">
        <i class="nav-icon fas fa-copy"></i>
        <p>
          Transaksi
          <i class="fas fa-angle-left right"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="{base_url()}transaksi" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/transaksi' !== false && $smarty.server.REQUEST_URI|strpos:'/transaksi/' === false}active{/if}">
            <i class="far fa-circle nav-icon text-info"></i>
            <p>Semua </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{base_url()}transaksi/proses" class="nav-link">
            <i class="far fa-circle nav-icon text-warning"></i>
            <p>Proses</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{base_url()}transaksi/selesai" class="nav-link">
            <i class="far fa-circle nav-icon text-success"></i>
            <p>Selesai</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{base_url()}transaksi/dibayar" class="nav-link">
            <i class="far fa-circle nav-icon text-danger"></i>
            <p>Dibayar</p>
          </a>
        </li>
      </ul>
    </li>
    <li class="nav-item has-treeview {if $smarty.server.REQUEST_URI|strpos:'/quotation' !== false}menu-open{/if}">
      <a href="#" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/quotation' !== false}active{/if}">
        <i class="nav-icon fas fa-clone"></i>
        <p>
          Quotation
          <i class="right fas fa-angle-left"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="{base_url()}quotation" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/quotation' !== false && $smarty.server.REQUEST_URI|strpos:'/quotation/' === false}active{/if}">
            <i class="far fa-circle nav-icon"></i>
            <p>Semua</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{base_url()}quotation/batal" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/quotation/batal' !== false}active{/if}">
            <i class="far fa-circle nav-icon"></i>
            <p>Batal</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{base_url()}quotation/add" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/quotation/add' !== false}active{/if}">
            <i class="far fa-circle nav-icon"></i>
            <p>Buat Baru</p>
          </a>
        </li>
      </ul>
    </li>
    <li class="nav-item has-treeview">
      <a href="#" class="nav-link">
        <i class="nav-icon fas fa-tree"></i>
        <p>
          SPB
          <i class="fas fa-angle-left right"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/general.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>General</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/icons.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Icons</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/buttons.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Buttons</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/sliders.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Sliders</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/modals.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Modals & Alerts</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/navbar.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Navbar & Tabs</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/timeline.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Timeline</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/UI/ribbons.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Ribbons</p>
          </a>
        </li>
      </ul>
    </li>
    <li class="nav-item has-treeview">
      <a href="#" class="nav-link">
        <i class="nav-icon fas fa-table"></i>
        <p>
          Invoice
          <i class="fas fa-angle-left right"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="{theme_url()}pages/tables/simple.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Simple Tables</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/tables/data.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>DataTables</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="{theme_url()}pages/tables/jsgrid.html" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>jsGrid</p>
          </a>
        </li>
      </ul>
    </li>
    <li class="nav-item has-treeview">
      <a href="{base_url()}customer" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/customer' !== false}active{/if}">
        <i class="nav-icon fas fa-users"></i>
        <p>
          Customer
        </p>
      </a>
    </li>
    <li class="nav-header">ADMINISTRASI</li>
    <li class="nav-item">
      <a href="{base_url()}users" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/users' !== false}active{/if}">
        <i class="nav-icon far fa-user"></i>
        <p>
          Users
          <span class="badge badge-info right">2</span>
        </p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{base_url()}settings" class="nav-link {if $smarty.server.REQUEST_URI|strpos:'/settings' !== false}active{/if}">
        <i class="nav-icon fas fa-cogs"></i>
        <p>
          Settings
        </p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{base_url()}auth/logout" class="nav-link">
        <i class="nav-icon fas fa-lock"></i>
        <p>
          Logout
        </p>
      </a>
    </li>
  </ul>
</nav>
