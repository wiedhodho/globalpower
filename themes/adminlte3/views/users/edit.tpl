{extends file="master/index.tpl"}

{block name='css'}
{/block}

{block name='js'}
<script>
$(function () {
  'use strict'
})
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
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <h5 class="card-title">Form Edit User</h5>

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
              <form class="form-horizontal" method="post" action="{base_url('users/update')}">
                <div class="card-body">
                  <div class="form-group row">
                    <label for="inputEmail3" class="col-sm-3 col-form-label">Nama Lengkap</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="inputEmail3" placeholder="Nama Lengkap" name="nama" value="{$user->users_nama}" required>
                      <input type="hidden" name="id" value="{$user->users_id}" required>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-3 col-form-label">Username</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="inputPassword3" placeholder="Username tanpa spasi" name="username" value="{$user->users_name}" required>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-3 col-form-label">Password</label>
                    <div class="col-sm-9">
                      <input type="password" class="form-control" placeholder="Password" name="password" >
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-3 col-form-label">Level</label>
                    <div class="col-sm-9">
                      <select class="form-control" name="level" required>
                        <option value=""> Pilih Level</option>
                        {foreach from=$level item=l key=k}
                        {if $k==$user->users_level}
                          {$selected='selected'}
                        {else}
                          {$selected=''}
                        {/if}
                        <option value="{$k}" {$selected}> {$l}</option>
                        {/foreach}
                      </select>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                  <button type="submit" class="btn btn-info"><i class="fa fa-save"></i> Simpan</button>
                </div>
                <!-- /.card-footer -->
              </form>
            </div>
            <!-- ./card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </div><!--/. container-fluid -->
  </section>
  <!-- /.content -->
</div>
{/block}
