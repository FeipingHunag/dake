object false
node(:error) { I18n.t(:invalid_resource, scope: "dake.api") }
node(:errors) { @resource.errors }