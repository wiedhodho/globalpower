{extends file="master/index.tpl"}

{block name='css'}
<link rel="stylesheet" href="{theme_url()}plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="{theme_url()}plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
{/block}

{block name='js'}
<script src="{theme_url()}plugins/datatables/jquery.dataTables.min.js"></script>
<script src="{theme_url()}plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="{theme_url()}plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="{theme_url()}plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script>
$(function () {
  'use strict'
  {if $smarty.session.error_message}
    toastr.{$smarty.session.error_tipe}("{$smarty.session.error_message}")
  {/if}
  $("#example1").DataTable({
    "responsive": true,
    "autoWidth": false,
  });
  $('#simpan').click(function(){
    let po = $('#po').val();
    po = po.replace(/ /g, '');
    if(po!=''){
      $.post( "{base_url()}spb/simpan", $( "#po_nomor" ).serialize())
      .done(function( data ) {
        if(data=='sukses')
          toastr.success("Nomor PO / REF telah dicatat!");
        else
          toastr.error("Nomor PO / REF gagal dicatat!");

        window.location.reload();
      });
    } else {
      toastr.error("Nomor PO / REF tidak benar");
    }
  })
});

function diproses(spb, quo){
  $('#spb').val(spb);
  $('#quo').val(quo);
  $('#modal-default').modal('show');
}
</script>
{/block}

{block name='content'}
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <div class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1 class="m-0 text-dark">{$halaman|end}</h1>
        </div><!-- /.col -->
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="{base_url()}">Home</a></li>
            {foreach from=$halaman item=a key=k}
            {if $a==$halaman|end}
            <li class="breadcrumb-item active">{$a}</li>
            {else}
            <li class="breadcrumb-item"><a href="{base_url()}{$k}">{$a}</a></li>
            {/if}
            {/foreach}
          </ol>
          <br />
        </div><!-- /.col -->
      </div><!-- /.row -->
    </div><!-- /.container-fluid -->
  </div>
  <!-- /.content-header -->

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="card card-info">
            <div class="card-header">
              <h5 class="card-title">Data Seluruh Delivery Notes</h5>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
                <button type="button" class="btn btn-tool" data-card-widget="remove">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="col-sm-12 text-center">
              <a href="{base_url()}spb/add" class="btn btn-sm btn-primary float-sm-right"><i class="fa fa-plus"></i> Tambah</a>
              </div>
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th width="5%">#</th>
                  <th width="10%">SPB No.</th>
                  <th width="10%">Quo No.</th>
                  <th>Customer</th>
                  <th>Tgl Kirim</th>
                  <th>Pengirim</th>
                  <th width="10%">Action</th>
                </tr>
                </thead>
                <tbody>
                {foreach from=$spb item=c}
                  {if $c->customer_site==''}
                    {$nama = $c->customer_nama}
                  {else}
                    {$nama = $c->customer_nama|cat:' - Site '|cat:$c->customer_site}
                  {/if}
                  <tr>
                    <td>{counter}</td>
                    <td>{$c->spb_nomor}</td>
                    <td>{$c->quotation_nomor}</td>
                    <td>{$nama}</td>
                    <td class="text-center">{$c->spb_tanggal}</td>
                    <td>{$c->spb_pengirim}</td>
                    <td class="text-center">
                        <a href="#" class="text-success" onClick="diproses({$c->spb_id}, {$c->quotation_id})"><i class="fa fa-check"></i> </a>&nbsp;
                        <a href="{base_url('spb/edit/')}{$c->spb_id}" class="text-info"><i class="fa fa-pencil-alt"></i></a>&nbsp;
                        <a href="{base_url('spb/download/')}{$c->spb_id}" class="text-secondary"><i class="fa fa-print"></i></a>&nbsp;
                        <a href="{base_url('spb/delete/')}{$c->spb_id}" class="text-danger" onclick="return confirm('Apakah anda ingin menghapus data ini?')"><i class="fa fa-times"></i></a>
                    </td>
                  </tr>
                {/foreach}
                </tbody>
              </table>
            </div>
            <!-- ./card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </div><!--/. container-fluid -->
    <div class="modal fade" id="modal-default">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">Input PO / REF</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form name="po_nomor" role="form" id="po_nomor">
              <div class="form-group">
                <label for="exampleInputEmail1">PO / REF</label>
                <input type="text" class="form-control" placeholder="Enter PO Number" name="po" id="po">
                <input type="hidden" id="quo" name="quo">
                <input type="hidden" id="spb" name="spb">
              </div>
            </form>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">Batal</button>
              <button type="button" class="btn btn-primary" id="simpan">Simpan</button>
          </div>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
  </section>
  <!-- /.content -->
</div>
{/block}
